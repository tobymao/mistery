class Views::Landing::Index < Views::Layouts::Page
  static :main

  def main
    h1 "Welcome to Mistery.io!"

    p do
    	text "This is a website where you can create and play your own mystery stories similar to the board game "
    	link_to("Sherlock Holmes: Consulting Detective", "http://boardgamegeek.com/boardgame/2511/sherlock-holmes-consulting-detective", target: "_blank")
    	text "."
    end

    p do
    	text "As a writer, create your own "
    	link_to("universes", new_universe_path)
    	text " and "
    	link_to("mysteries", new_scenario_path)
    	text " to solve."
    end

    p do
    	text "As a player, you can select a "
    	link_to("scenario", scenarios_path)
    	text " to play through. Visit any of the locations to look for clues, and when you feel like you can solve the case, answer the questions to find out your score!"
    end

    p do
    	text "This site is still heavily in development. We appreciate your feedback and we hope to grow a great community here."
    end

    p do
    	text "Email us at misterydotio [at] gmail [dot] com with any feedback."
    	br
    	text "This project is open source! View our "
    	link_to("GitHub", "https://github.com/tobymao/mistery", target: "_blank")
    	text "."
    end

  end
end
