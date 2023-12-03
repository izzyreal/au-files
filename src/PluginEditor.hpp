#pragma once

#include "juce_audio_processors/juce_audio_processors.h"
#include "PluginProcessor.hpp"

class PluginEditor : public juce::AudioProcessorEditor
{
public:
    explicit PluginEditor(PluginProcessor&);

    bool keyPressed(const juce::KeyPress &keyPress) override;
    void mouseDown(const juce::MouseEvent&) override;

private:
    PluginProcessor &pluginProcessor;
};
