require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user) }

  before { session[:user_id] = user.id }

  describe "#index" do

    let!(:task) { user.tasks.create(title: 'Title') }
    let!(:completed_task) { user.tasks.create(title: 'Title', completed: 'true') }

    context 'returns incompleted tasks' do
      before { get :index, format: :json, status: 'incompleted' }

      it { expect(response).to have_http_status(:success) }
      it { expect(json.first).to have_key('id') }
      it { expect(json.first).to have_key('user_id') }
      it { expect(json.first).to have_key('title') }
      it { expect(json.first).to have_key('completed') }
      it { expect(json.first).to have_key('priority') }
      it { expect(json.first['user_id']).to eq(user.id) }
      it { expect(json.first['title']).to eq(task.title) }
      it { expect(json.first['completed']).to be_falsy }
      it { expect(json).to have(1).items }
    end

    context 'returns completed tasks' do
      before { get :index, format: :json, status: 'completed' }

      it { expect(json.first).to be_truthy }
      it { expect(json.first).to have_key('id') }
      it { expect(json.first).to have_key('user_id') }
      it { expect(json.first).to have_key('title') }
      it { expect(json.first).to have_key('completed') }
      it { expect(json.first).to have_key('priority') }
      it { expect(json.first['title']).to eq(task.title) }
      it { expect(json.first['user_id']).to eq(user.id) }
      it { expect(json).to have(1).items }
    end
  end

  describe '#create' do
    let!(:task) { user.tasks.create(title: 'Title') }
    let(:task_attributes) { FactoryGirl.attributes_for(:task) }

    context 'adds a task' do
      it { expect { post :create, { task: task_attributes } }.to change(Task, :count).by(1) }
    end
  end

  describe "#destroy" do
    let!(:task) { user.tasks.create(title: 'Title') }

    context 'task removal' do
      it { expect{ delete :destroy, id: task.id }.to change(Task, :count).by(-1) }
    end
  end

  describe "#update" do
    let!(:task) { user.tasks.create(title: 'Title') }
    let(:task_attributes) { FactoryGirl.attributes_for(:task, title: 'New Title', priority: '33', due_date: '2015-01-01') }

    before do
      put :update, { id: task.id, task: task_attributes }
      task.reload
    end

    it { expect(task.title).to eq('New Title') }
    it { expect(task.priority).to eq(33) }
    it { expect(task.due_date).to eq('2015-01-01') }
  end
end
