#include "panel.h"

#include "uicommon.h"

void Panel::draw()
{
    ImGui::PushStyleColor(ImGuiCol_TitleBg, ImVec4(0.2f, 0.3f, 0.4f, 1.0f)); // Example color
    ImGui::PushStyleColor(ImGuiCol_TitleBgActive, ImVec4(0.3f, 0.4f, 0.5f, 1.0f)); // Example color
    ImGui::PushStyleColor(ImGuiCol_TitleBgCollapsed, ImVec4(0.1f, 0.2f, 0.3f, 1.0f)); // Example color


	bool* is_open_ptr = nullptr;
	if (is_closable_)
		is_open_ptr = &is_open_;

	if (has_resize)
	{
		ImGui::SetNextWindowSize(ImVec2(400, 600), ImGuiCond_FirstUseEver);
		ImGui::Begin(name().c_str(), is_open_ptr);
	}
	else
		ImGui::Begin(name().c_str(), is_open_ptr, ImGuiWindowFlags_NoResize | ImGuiWindowFlags_AlwaysAutoResize);

	// std::clog << "Drawing " << name() << std::endl;

	do_draw();

	ImGui::End();

    ImGui::PopStyleColor(3);
}
