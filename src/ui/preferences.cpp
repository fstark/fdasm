#include "preferences.h"

ImVec4 initial_colors[Preferences::kCount] = {
{ 0.955882, 0.281142, 0.281142, 1.000000 },
{ 0.857094, 0.956863, 0.278431, 1.000000 },
{ 0.956863, 0.577739, 0.278431, 1.000000 },
{ 0.219146, 0.659052, 0.931373, 1.000000 },
{ 0.956863, 0.278431, 0.278431, 1.000000 },
{ 0.278431, 0.956863, 0.298385, 1.000000 },
{ 0.965686, 0.574734, 0.227220, 1.000000 },
{ 0.241974, 0.667779, 0.931373, 1.000000 },
{ 0.956863, 0.278431, 0.278431, 1.000000 },
{ 0.956863, 0.278431, 0.278431, 1.000000 },
{ 0.278431, 0.877048, 0.956863, 1.000000 },
{ 0.956863, 0.278431, 0.278431, 1.000000 },
{ 0.123821, 0.980392, 0.009612, 1.000000 },
{ 0.262976, 0.558824, 0.000000, 1.000000 },
{ 0.049428, 0.508554, 0.916667, 1.000000 },
{ 0.000000, 0.000000, 0.000000, 1.000000 },
{ 0.730392, 0.719651, 0.719651, 1.000000 },
{ 1.000000, 1.000000, 1.000000, 1.000000 },
{ 0.000000, 0.000000, 0.000000, 1.000000 },
{ 0.822075, 0.995098, 0.014634, 1.000000 },
{ 0.017445, 0.017445, 0.593137, 1.000000 },
{ 1.000000, 0.000000, 0.000000, 1.000000 }
};

Preferences::Preferences( UI& ui )
    : Panel( ui )
{
    title_ = ICON_FA_GEAR" Preferences";
    memcpy( colors_, initial_colors, sizeof( initial_colors ) );
    load();
}

const char *adrs_color_names[Preferences::kCount] = {
	"Code out of ROM, in hex",
	"Data out of ROM, in hex",
	"Code in ROM, in hex",
	"Data in ROM, in hex",
	"Code out of ROM, as a global label",
	"Data out of ROM, as a global label",
	"Code in ROM, as a global label",
	"Data in ROM, as a global label",
	"Code out of ROM, as a local label",	//	unlikely
	"Data out of ROM, as a local label",	//	unlikely
	"Code in ROM, as a local label",
	"Data in ROM, as a local label",

    "Bytes",
    "Bytes (when selected)",
    "Opcodes in disassembly",
    "Operands in disassembly",
    "Comments",
    "Labels",
    "Labels (when selected)",
    "Strings in disassembly",
    "Selected line in disassembly",
    "I/O port"
};

void Preferences::load()
{
	//  Load the preferences from file fdasm.pref
	FILE* file = fopen("fdasm.pref", "r");
	if (file == NULL)
	{
		fprintf(stderr, "Failed to open file: %s\n", "fdasm.pref");
		return;
	}
    int i = 0;
	while (fscanf(file, "{ %f, %f, %f, %f },\n", &colors_[i].x, &colors_[i].y, &colors_[i].z, &colors_[i].w)==4)
    {
        if (colors_[i].w==0)
            colors_[i].w = 1;
        i++;
    }
	fclose(file);
}

void Preferences::save() const
{
	//  Save the preferences to file fdasm.pref
	FILE* file = fopen("fdasm.pref", "w");
	if (file == NULL)
	{
		fprintf(stderr, "Failed to open file: %s\n", "fdasm.pref");
		return;
	}
	for (int i=0;i!=kCount;i++)
	{
		fprintf(file, "{ %f, %f, %f, %f },\n", colors_[i].x, colors_[i].y, colors_[i].z, colors_[i].w);
	}
	fclose(file);
}

void Preferences::do_draw()
{
	if (ImGui::CollapsingHeader("Address colors"))
		for (int i=0; i!=8; i++)
		{
			if (ImGui::ColorEdit4(adrs_color_names[i], (float*)&colors_[i],ImGuiColorEditFlags_NoInputs))
				save();
		}

	if (ImGui::CollapsingHeader("Other colors"))
	{
		for (int i=12; i!=kCount; i++)
		{
            if (i==kOperandColor)
                continue;
			if (ImGui::ColorEdit4(adrs_color_names[i], (float*)&colors_[i],ImGuiColorEditFlags_NoInputs))
				save();
		}
	}
}

const ImVec4 &Preferences::get_color( int i ) const
{
    return colors_[i];
}
