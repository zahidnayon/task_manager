class Urls{
  Urls._();
  static String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTask = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String inCompleteTasks = '$_baseUrl/listTaskByStatus/Completed';
  static String inCancelTasks = '$_baseUrl/listTaskByStatus/Canceled';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';

  static String updateTask(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}