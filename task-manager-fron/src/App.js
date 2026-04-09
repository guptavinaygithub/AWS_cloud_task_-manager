import React, { useEffect, useState } from "react";

export default function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [editingTaskId, setEditingTaskId] = useState(null);
  const [editingTitle, setEditingTitle] = useState("");
  const [editingDescription, setEditingDescription] = useState("");
  const [editingStatus, setEditingStatus] = useState("PENDING");

  const API_URL = "http://cloud-task-manager-alb-1705967764.ap-south-1.elb.amazonaws.com/tasks";

  const fetchTasks = async () => {
    const res = await fetch(API_URL);
    const data = await res.json();
    setTasks(data);
  };

  const createTask = async () => {
    if (!title) return;
    await fetch(API_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title, description, status: "PENDING" }),
    });
    setTitle("");
    setDescription("");
    fetchTasks();
  };

  const deleteTask = async (id) => {
    await fetch(`${API_URL}/${id}`, { method: "DELETE" });
    fetchTasks();
  };

  const startEditing = (task) => {
    setEditingTaskId(task.id);
    setEditingTitle(task.title);
    setEditingDescription(task.description);
    setEditingStatus(task.status);
  };

  const updateTask = async (id) => {
    await fetch(`${API_URL}/${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title: editingTitle, description: editingDescription, status: editingStatus }),
    });
    setEditingTaskId(null);
    fetchTasks();
  };

  useEffect(() => {
    fetchTasks();
  }, []);

  return (
    <div className="min-h-screen bg-gray-100 p-6">
      <div className="max-w-3xl mx-auto space-y-6">
        <h1 className="text-3xl font-bold text-center">🚀 Cloud Task Manager</h1>

        <div className="bg-white rounded-lg shadow p-4 space-y-4">
          <input
            className="w-full border rounded px-3 py-2"
            placeholder="Task Title"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
          <input
            className="w-full border rounded px-3 py-2"
            placeholder="Task Description"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          />
          <button
            className="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-600"
            onClick={createTask}
          >
            Add Task
          </button>
        </div>

        <div className="space-y-4">
          {tasks.map((task) => (
            <div
              key={task.id}
              className="bg-white p-4 rounded shadow flex flex-col md:flex-row justify-between items-start md:items-center"
            >
              {editingTaskId === task.id ? (
                <div className="flex flex-col space-y-2 w-full md:w-2/3">
                  <input
                    className="border rounded px-2 py-1"
                    value={editingTitle}
                    onChange={(e) => setEditingTitle(e.target.value)}
                  />
                  <input
                    className="border rounded px-2 py-1"
                    value={editingDescription}
                    onChange={(e) => setEditingDescription(e.target.value)}
                  />
                  <select
                    className="border rounded px-2 py-1"
                    value={editingStatus}
                    onChange={(e) => setEditingStatus(e.target.value)}
                  >
                    <option value="PENDING">PENDING</option>
                    <option value="DONE">DONE</option>
                  </select>
                </div>
              ) : (
                <div className="w-full md:w-2/3">
                  <p className="font-semibold">{task.title}</p>
                  <p className="text-sm text-gray-500">{task.description}</p>
                  <p className="text-xs mt-1">Status: {task.status}</p>
                </div>
              )}

              <div className="flex space-x-2 mt-2 md:mt-0">
                {editingTaskId === task.id ? (
                  <>
                    <button
                      className="bg-green-500 text-white px-3 py-1 rounded hover:bg-green-600"
                      onClick={() => updateTask(task.id)}
                    >
                      Save
                    </button>
                    <button
                      className="bg-gray-300 text-black px-3 py-1 rounded hover:bg-gray-400"
                      onClick={() => setEditingTaskId(null)}
                    >
                      Cancel
                    </button>
                  </>
                ) : (
                  <>
                    <button
                      className="bg-yellow-500 text-white px-3 py-1 rounded hover:bg-yellow-600"
                      onClick={() => startEditing(task)}
                    >
                      Edit
                    </button>
                    <button
                      className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
                      onClick={() => deleteTask(task.id)}
                    >
                      Delete
                    </button>
                  </>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}