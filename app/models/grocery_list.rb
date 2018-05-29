require "httparty"

WUNDERLIST_URI = "http://a.wunderlist.com/api/v1/tasks"
LIST_ID = 140067646

class GroceryList < ApplicationRecord
  has_many :ingredients

  def send_to_wunderlist
    headers = {"X-Client-ID": ENV['CLIENT_ID'], "X-Access-Token": ENV['ACCESS_TOKEN'], "Content-Type": "application/json"}
    self.ingredients.each do |ingredient|
      post_body = {
        "list_id": LIST_ID,
        "title": "#{ingredient.quantity} #{ingredient.name}"
      }
      response = HTTParty.post(WUNDERLIST_URI, headers: headers, body: post_body.to_json, :debug_output => $stdout)
      if !response.success?
        return "Unable to post to wunderlist!"
      end
    end
    return "Success"
  end
end
