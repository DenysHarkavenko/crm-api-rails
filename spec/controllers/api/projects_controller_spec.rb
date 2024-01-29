require 'rails_helper'

RSpec.describe Api::ProjectsController, type: :controller do
  def set_user_headers
    user = create(:user)
    request.headers['X-User-Email'] = user.email
    request.headers['X-User-Token'] = user.authentication_token
    user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      set_user_headers

      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new project' do
      user = set_user_headers

      project_attributes = attributes_for(:project)

      expect do
        post :create, params: { project: project_attributes }
      end.to change(Project, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH #update' do
    it 'updates an existing project' do
      user = set_user_headers

      project_attributes = attributes_for(:project)

      post :create, params: { project: project_attributes }
      created_project = Project.last

      updated_attributes = { name: 'Updated Name', description: 'Updated Description' }
      patch :update, params: { id: created_project.id, project: updated_attributes }
      created_project.reload

      expect(created_project.name).to eq('Updated Name')
      expect(created_project.description).to eq('Updated Description')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys an existing project' do
      user = set_user_headers

      project_attributes = attributes_for(:project)

      post :create, params: { project: project_attributes }
      created_project = Project.last

      expect do
        delete :destroy, params: { id: created_project.id }
      end.to change(Project, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
