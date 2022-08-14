---------------------------Back-end Challenge-------------------------------

Run Commands

------------------------Decision Making Walking Through ---------------------

-docker-compose run api rails new . --force --api --database=mysql --skip-bundle

sudo chown -R $USER:$USER .

docker-compose run api rake db:create

installing some extra gems

---------------------------------system analysis-------------------------

we have 3 tables featuring applications, chats and messages

applications has many chats and chats has many messages

starting with the parent

- rails g model application > updating atr in the migration files

-rails g model chat messages_count:integer chat_id:integer application:references
-rails g model messages chat:references

-after model migrate to db rake db:migrate

--then controllers

---

allowing cors using rack ... notice i allowed \* instead of specific list as this is a development not production

config.middleware.insert*before 0, Rack::Cors do
allow do
origins '*'
resource(
'\_',
headers: :any,
methods: [:get,:post,:patch,:put,:delete,:options]
)
end
end

---

using simple token auth for generating app token each time app.save triggered

nested resources

---

race condition and app logic :

- the most raced resource will be messages_count as concurrent requests will affect the true value for this shared col so i will have a persistent queue handled by redis to store messages in queue by a worker (sidekiq) most probably and serve it in order to database with a delayed time frame then the system will give a persistent messages_count by the call of each create request so it can be served rapidly

so logic goes as follows

1-load all chats with it's messages_count(can be thought as last_message_id) into redis and lock both of them -at the start of the app-

2-when receiving create message start incrementing in redis and queuing messages to be persistent by a worker

-- i thought of doing the same to the chat_count but i called it off as the no of messages to be counted is significantly higher than chat and this what will be raced .
