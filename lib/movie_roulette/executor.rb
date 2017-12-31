require_relative 'commands/main'
require_relative 'commands/genre_selection'
require_relative 'commands/tell_me_more'
require_relative 'commands/tell_me_about'

module Executor
  class << self
    def execute(data, response)
      assistant_response = GoogleAssistant.respond_to(data, response) do |assistant|
        assistant.intent.main do
          assistant.conversation.state = 'asking genre'
          MainCommand.new(assistant).execute
        end

        assistant.intent.text do
          if assistant.conversation.state == 'asking genre'
            assistant.conversation.state = 'movie chosen'
            GenreSelection.new(assistant).execute
          elsif assistant.conversation.state == 'movie chosen'
            puts assistant.conversation.state
            case assistant.arguments[0].text_value.downcase
            when 'tell me more'
              assistant.conversation.state = 'movie chosen'
              TellMeMore.new(assistant).execute
            when 'something else'
              assistant.conversation.state = "asking genre"
              assistant.conversation.data['movie'] = nil
              respond_with = 'What genre would you like?'
              assistant.ask(respond_with, [respond_with])
            else
              assistant.conversation.state = 'movie chosen'
              TellMeAbout.new(assistant).execute
              # assistant.tell('Lets try again later')
            end
          else
            assistant.tell('Lets try again later')
          end
        end
      end
    end
  end
end
