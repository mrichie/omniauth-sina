require 'omniauth-oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Sina < OmniAuth::Strategies::OAuth
      option :name, 'sina'
      option :client_options, {:authorize_path => '/oauth/authorize',
                               :site => 'http://api.t.sina.com.cn'}

      uid { access_token.params[:user_id] }

      info do
        {
          :nickname => raw_info['screen_name'],
          :name => raw_info['name'],
          :location => raw_info['location'],
          :image => raw_info['profile_image_url'],
          :description => raw_info['description'],
          :urls => {
            'Website' => raw_info['url'],
            'Sina' => 'http://api.t.sina.com.cn/' + raw_info['screen_name'],
          }
        }
      end

    end
  end
end
