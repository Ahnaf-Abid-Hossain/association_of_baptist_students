module ProfanityHelper
  require 'httparty' # Add this line to include HTTParty

  def check_for_profanity(text)
    profanity_api_url = "https://www.purgomalum.com/service/containsprofanity?text=#{text}"

    # Make a POST request to the profanity API
    response = HTTParty.get(profanity_api_url)

    if response.success?
      result = JSON.parse(response.body)
        return result
    else
      # Handle API request errors
      return "Error: Failed to check for profanity"
    end
  end
end