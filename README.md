---------------------------Back-end Challenge-------------------------------

Run Commands

docker-compose up --build


routes are nested and can be found using docker-compose run api rails routes


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

- current implementation of chat_count and chat_number does not support concurrency and may inflict problems to be compared with the other count (messages_count).

- the most raced resource will be messages_count as concurrent requests will affect the true value for this shared col so i will have a persistent queue handled by redis to store messages in queue by a worker (sidekiq) most probably and serve it in order to database with a delayed time frame then the system will give a persistent messages_count by the call of each create request so it can be served rapidly

so logic goes as follows

1-load all chats with it's messages_count(can be thought as last_message_id) into redis and lock both of them -at the start of the app-

2-when receiving create message start incrementing in redis and queuing messages to be persistent by a worker

- i made 2 sidekiq queues one for each lock.

- i thought of doing the same to the chat_count but i called it off as the no of messages to be counted is significantly higher than chat and this what will be raced .

- i did not implement update - show for chat as i think they 're useless in this case.

- messages_count is not rendered for some reason hadn't enough time to debug it.
- Elastic search container is not working properly so i commented it out i could not fix the bugs before the deadline ... so sorry for that but the way i think of it as a routine worker (maybe sidekiq-cron) to run elastic indexing every 30 mins to index messages then searching will be easier...

-sorry i wish i could 've finished it all well
