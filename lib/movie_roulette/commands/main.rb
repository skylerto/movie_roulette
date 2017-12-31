class MainCommand
  def initialize(assistant)
    @assistant = assistant
  end

  def execute
    @assistant.ask(
      "<speak>Hello, what genre would you like?</speak>",
      [
        "<speak>If you said something, I didn't hear you.</speak>",
        "<speak>Did you say something?</speak>"
      ]
    )
  end
end
