var app = angular.module('dashboard',['account-module','dashboard-module','notifications-module']);

app.controller('dashboardCtrl',function($scope,dashboard) {

	$scope.module = {
		id: 'dashboard',
		privileges: {

		}
	};

});