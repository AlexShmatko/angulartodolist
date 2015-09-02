var app = angular.module('Todolist', ['ngResource', 'xeditable']);

app.run(function(editableOptions) {
  editableOptions.theme = 'bs3';
});

app.controller('TasksCtrl', [
  '$scope', 'Task', function($scope, Task) {

    $scope.user = gon.current_user

    $scope.updateTitle = function(data, task) {
      Task.update({
        user_id: $scope.user.id,
        id: task.id,
        title: data
      });
    };

    $scope.updatePriority = function(data, task){
      Task.update({
        user_id: $scope.user.id,
        id: task.id,
        priority: data
      })
    };

    $scope.updateDueDate = function(task) {
      var autoclose = this;
      $('ul.tasks form input').datepicker({
        dateFormat: 'yy-mm-dd',
        onSelect: function(date, instance) {
          task.due_date = date;
          Task.update({
            user_id: $scope.user.id,
            id: task.id
          }, {
            due_date: date
          });
          autoclose.$editable.scope.$form.$cancel();
        }
      });
    };

    $scope.tasks = Task.query({
      user_id: $scope.user.id,
      status: 'incompleted'
    });

    $scope.completedTasks = Task.query({
      user_id: $scope.user.id,
      status: 'completed'
    });

    $scope.addNewTask = function() {
      var task = Task.save({user_id: $scope.user.id}, ($scope.newText));
      $scope.tasks.push(task);
      $scope.newText = {};
    };

    $scope.deleteTask = function(task){
      if (confirm('Are you sure')) {
        var index = $scope.tasks.indexOf(task);
        Task.delete({ user_id: $scope.user.id, id: task.id },
          function(success){
            $scope.tasks.splice(index, 1);
        });
      }
    };

    $scope.complete = function(task) {
      Task.update({
        user_id: $scope.user.id,
        id: task.id,
        task: {
          completed: true
        }
      }, function() {
        var index;
        index = $scope.tasks.indexOf(task);
        $scope.tasks.splice(index, 1);
        $scope.completedTasks.push(task);
      });
    };

    $scope.restore = function(task) {
      Task.update({
        user_id: $scope.user.id,
        id: task.id,
        task: {
          completed: false
        }
      }, function() {
        var index;
        index = $scope.completedTasks.indexOf(task);
        $scope.completedTasks.splice(index, 1);
        $scope.tasks.push(task);
      });
    };

    $scope.sort = function(property) {
      var  arrow = $("#" + property);
      var direction;
      $('.sort .glyphicon');
           arrow.addClass('incompleted');
      if (arrow.hasClass('glyphicon-arrow-down')) {
        arrow.removeClass('glyphicon-arrow-down');
        arrow.addClass('glyphicon-arrow-up');
        direction = 'desc';
      } else {
        arrow.addClass('glyphicon-arrow-down');
        arrow.removeClass('glyphicon-arrow-up');
        direction = 'asc';
      }
      $scope.tasks = Task.query({
        user_id: $scope.user.id,
        status: 'incompleted',
        order_by: property,
        direction: direction
      });
    };

  }
]);

