#include "PluginEditor.hpp"

#include "AuFiles.hpp"

PluginEditor::PluginEditor(PluginProcessor& p)
        : AudioProcessorEditor(&p), pluginProcessor(p)
{
    setSize(320, 200);
    setWantsKeyboardFocus(true);
}

bool PluginEditor::keyPressed(const juce::KeyPress &)
{
    return true;
}

void PluginEditor::mouseDown(const juce::MouseEvent &)
{
    AuFilesCpp::presentDocumentBrowserCpp();
}
