  app.factory('Task', [
    '$resource', function($resource) {
      return $resource('/users/:user_id/tasks/:id', {user_id: '@user_id', id: '@id'}, {update: {method: 'PUT'}});
     }
  ]);
