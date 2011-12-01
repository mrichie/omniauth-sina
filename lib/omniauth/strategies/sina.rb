module OmniAuth
  module Strategies
    class Sina < OmniAuth::Strategies::Auth
      option :name, 'sina'
      option :client_options, {
        :authorize_path => '/oauth/authorize',
        :site => 'http://api.t.sina.com.cn',
        :request_token_path => '/oauth/request_token',
        :access_token_path => '/oauth/access_token'
      }
      
      option :callback_confirmed, true

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
            'Sina' => 'http://weibo.com/' + raw_info['screen_name'],
          }
        }
      end
      
      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/account/verify_credentials.json').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end
