class MainCommand
  def initialize(assistant)
    @assistant = assistant
  end

  def execute
    @assistant.conversation.state = "asking genre"
    @assistant.ask(
      "<speak>Hello, what genre would you like?</speak>",
      [
        "<speak>If you said something, I didn't hear you.</speak>",
        "<speak>Did you say something?</speak>"
      ]
    )
  end
end
