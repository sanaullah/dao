<!DOCTYPE html>
<html >
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1"/>

    <title>Breeze Todos with AngularJs (Backed by CFML via DAO)</title>
    <link rel="stylesheet" href="assets/css/reset.css" />
    <link rel="stylesheet" href="assets/css/toastr.css" />
    <link rel="stylesheet" href="assets/css/todo.css" />
</head>
<body data-ng-app="todo" data-ng-controller="TodoCtrl">

    <div id="applicationHost"  class="ng-cloak">
        <header>
            <h1>Breeze Todos</h1>
            <h2>with AngularJs & DI (Backed by CFML via DAO)</h2>
            <form data-ng-submit="addItem()">
                <input type="text" data-ng-model="newTodo" placeholder="What needs to be done?" />
            </form>
        </header>

        <section>
            <div class="mark-all">
                <span data-ng-show="items.length">
                    <input id="markAll" type="checkbox" data-ng-model="allCompleted" data-ng-click="toggleCompleted()" />
                    <label for="markAll">Mark all as complete </label>
                </span>

                <input id="includeArchived" type="checkbox" data-ng-model="includeArchived" data-ng-click="getAllTodos()" />
                <label for="includeArchived" class="archived">Show archived</label>
            </div>
            <div>
              <!--[if lte IE 9]><span style='font-size:.5em;'>Filter </span><![endif]-->
              <input data-ng-model="searchText" type="search" placeholder="Filter by name ..." />
            </div>
            <ul>
                <li data-ng-repeat="item in items | filter:itemFilter">
                    <div data-ng-show="!(item.isEditing)">
                         <!--data-ng-class on the checkbox in the next line is a fix for a subtle IE9 repaint bug-->
                        <input type="checkbox" data-ng-model="item.isDone" data-ng-class="{done: item.isDone}" />
                        <label data-ng-click="edit(item)" data-ng-class="{done: item.isDone, archived: item.isArchived}" >{{item.description}}</label>
                        <a href="#" data-ng-click="removeItem(item)">X</a>
                    </div>
                    <div data-ng-show="item.isEditing">
                        <form data-ng-submit="completeEdit(item)">
                            <input type="text" data-ng-model="item.description" data-on-blur="completeEdit(item)" data-focus-when="item.isEditing" />
                        </form>
                    </div>
                </li>

            </ul>

            <div class="controlLinks">
                <a href="#" data-ng-click="purge()">Purge</a>&nbsp;&nbsp;
                <a href="#" data-ng-click="reset()">Reset</a>
            </div>
        </section>

        <footer>
            <div data-ng-show="itemsLeftMessage()">{{itemsLeftMessage()}}</div>
            <a href="#" data-ng-show="archiveCompletedMessage()" data-ng-click="archiveCompletedItems()">{{archiveCompletedMessage()}}</a>
        </footer>

    </div>

    <!-- 3rd party libraries -->
    <script src="Scripts/jquery-1.8.3.min.js"></script>
    <script src="Scripts/q.js"></script>
    <script src="Scripts/breeze.debug.js"></script>
    <script src="Scripts/breeze.savequeuing.js"></script>
    <script src="Scripts/toastr.js"></script>
    <script src="Scripts/angular.js"></script>

    <!-- App libraries -->
    <script src="Scripts/app/main.js"></script>
    <script src="Scripts/app/logger.js"></script>
    <script src="Scripts/app/dataservice.js"></script>
    <script src="Scripts/app/controller.js"></script>

</body>
</html>
