require 'byebug'
require 'cgi'

class FeedbackRequestController < ApplicationController

  def thumbs
    url = "https://script.google.com/macros/s/AKfycbzF4JtOZlnaJBCaIJpR8NcnfeVgAXHBuaoXXqZjrlnBf0HqQfg5/exec?Feedback=#{params['feedback']}&CourseID=#{params['course_id']}&LessonType=#{params['lesson_type']}&LessonID=#{params['lesson_id']}&Course=#{CGI.escape(params['course'])}&UserID=#{params['user_id']}"
    headers = {
      content_type: :json, 
      accept: :json
    }

    response = RestClient.get(url, headers)

    render json: response.body
  end

  def slack
    url = 'https://hooks.slack.com/services/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'
    # Each block renders as a new line in Slack's messaging
    payload = {
      "blocks": [
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "#{params['user_name']} is requesting help in the #{params['course']} course"
          }
        },
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "#{params['user_name']}'s question: #{params['message']}"
          }
        },
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "Canvas lesson: https://learning.flatironschool.com/#{params['course_id']}/#{params['lesson_type']}/#{params['lesson_id']}"
          }
        }
      ]
    }.to_json
  headers = {
    content_type: :json, 
    accept: :json
  }
  response = RestClient.post(url, payload, headers)
  
  render json: response.body
  end
end
