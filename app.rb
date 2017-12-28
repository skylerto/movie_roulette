require 'sinatra'
require 'google_assistant'

get '/' do
  'Hello world!'
end

post '/' do
  assistant_response = GoogleAssistant.respond_to(params, response) do |assistant|
    assistant.intent.main do
      assistant.ask(
        prompt: "<speak>Hi there! Say something, please.</speak>",
        no_input_prompt: [
          "<speak>If you said something, I didn't hear you.</speak>",
          "<speak>Did you say something?</speak>"
        ]
      )
    end

    assistant.intent.text do
      assistant.tell("<speak>I can respond, too!</speak>")
    end
  end

  render json: assistant_response
end
