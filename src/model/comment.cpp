#include "comment.h"

#include <iostream>

Comment::Comment(adrs_t adrs, const std::string& text, bool user)
    : adrs_{ adrs }
    , user_{ user }
    , comment_text_{ text }
{
}

CommentText::CommentText( const std::string &text )
    : text_{ text }
{
    chunkify();
}

std::vector<std::string> chunkify( const std::string &text )
{
    std::vector<std::string> result;

    //  We create the chunks_ vector that contains fragments
    //  The comment:
    //  "This is a @comment that have five @chunks."
    //  will be transformed into:
    //  "This is a ", "@comment", " that have five ", "@chunks", "."

    //  Find the first '@'
    size_t start = 0;
    size_t end = 0;
    while (end < text.size())
    {
        //  Find the next '@'
        end = text.find('@', start);
        if (end != std::string::npos)
        {
            result.push_back(text.substr(start, end - start));
        }
        else
        {
            //  No more '@' found
            result.push_back(text.substr(start));
            break;
        }
        start = end+1;

        //  Find the next character not in '_A-Za-z0-9'
        end++;
        while (end!=text.size())
        {
            auto c = text[end];
            bool ok = false;
            if (c=='_') ok = true;
            if (c>='A' && c<='Z') ok = true;
            if (c>='a' && c<='z') ok = true;
            if (c>='0' && c<='9') ok = true;
            if (!ok)
                break;
            end++;
        }
        if (end==text.size())
            end = std::string::npos;
        // end = text_.find(' ', start);

        if (end == std::string::npos)
        {
            //  No more space found
            result.push_back(text.substr(start));
            break;
        }
        result.push_back(text.substr(start, end - start));
        start = end;
    }

    return result;
}

void CommentText::chunkify()
{
    chunks_ = ::chunkify(text_);
    //  Extract first line
    size_t end = text_.find('\n');
    if (end == std::string::npos)
    {
        first_chunks_ = ::chunkify(text_);
    }
    else
    {
        first_chunks_ = ::chunkify(text_.substr(0, end));
    }
}
