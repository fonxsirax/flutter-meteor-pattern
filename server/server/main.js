import { Meteor } from 'meteor/meteor';
import { Accounts } from 'meteor/accounts-base';
import { PostModel} from '../imports/collections';
import {check} from "meteor/check";

Meteor.publish('listenPosts', function() {
  if (this.userId) {
    return PostModel.find({}, {sort: { createdAt: 1 }});
  }
  this.ready();
});

Meteor.publish(null, function() {
  if (this.userId) {
    return Meteor.users.find({}, {
      fields: {
        username: 1,
        profile: 1,
      },
    });
  }
  this.ready();
});

//criação de usuário pros 2 exemplos
Meteor.methods({
  'createPlayer' (info) {
    console.log("Entrando em createUser!");
    check(info, Object);
    try {
      Accounts.createUser({
        username: info.username,
        password: info.password,
        profile: {
          name: "name",
          surname: "surname",
        },
      });
      console.log("success!");
    } catch (err) {
      console.log("error:");
      console.log(err);
    }
  }
})

//Exemplo novo PostModel:
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

//esse eu usei pro outro exemplo
/*Meteor.methods({
  'sendMessage'(msg) {
    console.log("recendo menssagem..." + msg);
    check(msg, String);
    if (!this.userId) {
      throw new Meteor.Error(401, 'Unauthorized');
    }
    Messages.insert({
      from: this.userId,
      msg: msg,
      createdAt: new Date(),
    });
  },
  'createDataOther' (data) {

  },
  'deleteAllMessages'() {
    if (!this.userId) {
      throw new Meteor.Error(401, 'Unauthorized');
    }
    Messages.remove({});
  },
  'deleteMessage' (_id) {
    if (!this.userId) {
      throw new Meteor.Error(401, 'Unauthorized');
    }
    Messages.remove({
      _id
    });
  },
  'editMessage' (_id, data) {
    console.log("editando usuário");
    if (!this.userId) {
      throw new Meteor.Error(401, 'Unauthorized');
    }
    Messages.update({_id: _id}, {$set: {msg: data}});
  }
});*/




///aquela mokada pra me ajudar
try {
  Accounts.createUser({
    username: 'user1',
    password: 'password1',
    profile: {
      name: 'Apple',
      surname: 'Seed',
    },
  });
} catch (err) {}

try {
  Accounts.createUser({
    username: 'user2',
    password: 'password2',
    profile: {
      name: 'John',
      surname: 'Doe',
    },
  });
} catch (err) {}

