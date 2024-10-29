#pragma once

#include "panel.h"

//  A panel that *inspects* a specific piece of data
//  TODO: Such panels could have some sort of history to move accross different data
template <class T>
class InspectorPanel : public Panel
{
public:
	InspectorPanel(UI& ui, T data)
	    : Panel(ui)
	    , datas_{ data }
	{
		title_ = "";
		id_    = std::to_string((long)this); //  #### Another Unique ID would be better

		data_changed();
	}

	T data() const { return datas_[index_]; }
	int index() const { return index_; }
	int count() const { return datas_.size(); }
	void prev() { index_ = (index_ - 1 + datas_.size()) % datas_.size(); data_changed(); }
	void next() { index_ = (index_ + 1) % datas_.size(); data_changed(); }

	void set_data( T data );

protected:
	virtual void data_changed() {}

	virtual void DoDraw() override;

	virtual void DoDrawData() = 0;

private:
	std::vector<T> datas_;
	int index_ = 0;
};

template <class T>
void InspectorPanel<T>::set_data( T d )
{
	if (d==data())
	{
	    data_changed();	//	For inspectors that want to reset to this exact data
		return;
	}

    //	Truncate at index
    datas_.resize(index_+1);

    //	Append next data
    datas_.push_back(d);

    //	Reset index
    index_ = datas_.size()-1;

    //	Notify
    data_changed();
}

#include "uicommon.h"

template <class T>
void InspectorPanel<T>::DoDraw()
{
	//	A left and right button to navigate the data
	if (ImGui::ArrowButton("left", ImGuiDir_Left))
		prev();
	ImGui::SameLine();
	ImGui::Text("%d/%d", index() + 1, count());
	ImGui::SameLine();
	if (ImGui::ArrowButton("right", ImGuiDir_Right))
		next();

	DoDrawData();
}
