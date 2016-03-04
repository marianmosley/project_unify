module Api::V1::UsersDoc
  extend Apipie::DSL::Concern

  api :GET, '/v1/users/', 'List of resources: User'
  formats %w(json)
  header 'X-User-Email', 'email', required: true
  header 'X-User-Token', 'authentication token', required: true
  description 'Returns a list of registered users with URL\'s to #show for each instance'
  example %q(
  Response:
  {
   "users":[
      {
         "id":1,
         "user_name":"Thomas Ochman",
         "created_at":"2016-02-22T17:46:07.045Z",
         "profile":"http://localhost:3000/api/v1/users/1"
      },
      {
         "id":2,
         "user_name":"Anders Andersson",
         "created_at":"2016-02-22T17:46:24.915Z",
         "profile":"http://localhost:3000/api/v1/users/2"
      }
   ]
}

)

  def index
  end

  api :GET, '/v1/users/:id', 'Show a :resource'
  description 'Returns an instance of user'
  formats %w(json)
  header 'X-User-Email', 'email', required: true
  header 'X-User-Token', 'authentication token', required: true
  example %q(
  Response:
  {
   "user":{
      "id":1,
      "user_name":"Thomas Ochman",
      "created_at":"2016-02-22T17:46:07.045Z"
   }
})

  def show
  end

  api :GET, '/v1/unify/:id', 'Show a list of matches for :resource'
  description 'Returns an instance of user with an array of matched users'
  formats %w(json)
  header 'X-User-Email', 'email', required: true
  header 'X-User-Token', 'authentication token', required: true
  example %q(
  Response:
  {
   "user":{
      "id":1,
      "user_name":"Thomas Ochmane333",
      "skills":[
         "agile",
         "html",
         "management",
         "rspec",
         "test2",
         "test",
         "java"
      ],
      "created_at":"2016-02-22T17:46:07.045Z"
   },
   "matches":[
      {
         "user":{
            "id":2,
            "user_name":"Anders Andersson",
            "created_at":"2016-02-22T17:46:24.915Z",
            "skills":[
               "rspec",
               "html",
               "test",
               "management"
            ],
            "profile":"http://localhost:3000/api/v1/users/2"
         }
      },

      {
         "user":{
            "id":5,
            "user_name":"Kalle",
            "created_at":"2016-02-23T12:04:27.736Z",
            "skills":[
               "java",
               "html",
               "javascript"
            ],
            "profile":"http://localhost:3000/api/v1/users/5"
         }
      }
   ]
}

)

  def unify
  end

  api :POST, '/v1/skills/:id', 'Updates skill list for :resource'
  description 'Allows updating authorized resourse to update its own skill list.'
  formats %w(json)
  header 'X-User-Email', 'email', required: true
  header 'X-User-Token', 'authentication token', required: true
  def skills
  end
end
