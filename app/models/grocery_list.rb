require "httparty"

WUNDERLIST_URI = "http://a.wunderlist.com/api/v1/tasks"
LIST_ID = 140067646

class GroceryList < ApplicationRecord
  has_many :ingredients, as: :parent_list

  def consolidate_ingredients!
    self.ingredients.each do |ingredient_a|
      self.ingredients.each do |ingredient_b|
        if ingredient_a != ingredient_b
          if ingredient_a.name == ingredient_b.name && ingredient_a.unit == ingredient_b.unit
            ingredient_a.quantity += ingredient_b.quantity unless ingredient_a.destroyed? || ingredient_b.destroyed?
            ingredient_a.save!
            self.ingredients.delete(ingredient_b)
            Ingredient.delete(ingredient_b.id)
          end
        end
      end
    end
    self.save
  end

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
