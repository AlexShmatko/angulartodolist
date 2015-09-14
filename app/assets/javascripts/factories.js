  app.factory('Task', [
    '$resource', function($resource) {
       return $resource('/tasks/:id', {id: '@id'}, {update: {method: 'PUT'}});
     }
  ]);
