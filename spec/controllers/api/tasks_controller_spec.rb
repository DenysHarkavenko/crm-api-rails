require 'rails_helper'

RSpec.describe Api::TasksController, type: :controller do
  def set_user_headers
    user = create(:user)
    request.headers['X-User-Email'] = user.email
    request.headers['X-User-Token'] = user.authentication_token
    user
  end

  describe 'GET #index' do
    it 'returns a list of tasks for a project' do
      user = set_user_headers
      project = create(:project)

      get :index, params: { project_id: project.id }

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new task for the project' do
      user = set_user_headers
      project = create(:project)

      task_attributes = attributes_for(:task)

      expect do
        post :create, params: { project_id: project.id, task: task_attributes }
      end.to change(Task, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH #update' do
    it 'updates an existing task' do
      user = set_user_headers
      project = create(:project)
      task = create(:task, project: project)

      updated_attributes = { name: 'Updated Name', description: 'Updated Description' }

      patch :update, params: { project_id: project.id, id: task.id, task: updated_attributes }
      task.reload

      expect(task.name).to eq('Updated Name')
      expect(task.description).to eq('Updated Description')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes an existing task' do
      user = set_user_headers
      project = create(:project)
      task = create(:task, project: project)

      expect do
        delete :destroy, params: { project_id: project.id, id: task.id }
      end.to change(Task, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
