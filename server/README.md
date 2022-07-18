# arquiteturadesoftware

      This project was developed with the aim of promoting a good style of programming, so that several people can work together on the same project and the expected result will be the desired.

## Getting Started

      - This is the Server Part of flutter-meteor-pattern to find the client part go to .../client/ .
      - We are going to use Meteor and Mongo to implement the results of a server.

## Setup server

- You should have Node installed. Bash to flutter-meteor-pattern\server and install npm packages with:
```
npm install
```
- After install node packages we can open the meteor server with:
```
npm start
```

## Collections
PostModel collection with:
- String: _id,
- String: title,
- String: description,
- DateTime: createdAt
```
export const PostModel = new Mongo.Collection('PostModel')
```

## Server Validations
We aways validate if the received packages has the expected type of data with
```
import {check} from "meteor/check";
check(package.username, String);
```
## Examples 
```javascript
Meteor.methods({
  'createPostModel'(tittle, description) {
    console.log("recebendo post..." + tittle);
    check(tittle, String);
    check(description, String);

    if (!this.userId) {
      throw new Meteor.Error(401, 'Unauthorized');
    }
    PostModel.insert({
      from: this.userId,
      tittle: tittle,
      description: description,
      createdAt: new Date(),
    });
    console.log("post criado com sucesso!");
  },
  'getAllPosts'(){
    console.log("entrando em getAllPosts");
    return PostModel.find({}).fetch();
  },
  'deleteAllPostModels'() {
    if (!this.userId) {
      throw new Meteor.Error(401, 'Unauthorized');
    }
    PostModel.remove({});
  },
  'deletePostModel' (_id) {
    if (!this.userId) {
      throw new Meteor.Error(401, 'Unauthorized');
    }
    PostModel.remove({
      _id
    });
  },
  'editPostModel' (_id, tittle, description) {
    console.log("editando Post Model"+_id+tittle+description);
    if (!this.userId) {
      throw new Meteor.Error(401, 'Unauthorized');
    }
    PostModel.update({_id: _id}, {$set: {tittle: tittle, description: description}});
  }
});
```




