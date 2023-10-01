require 'rails_helper'

RSpec.describe(MeetingNotesController, type: :routing) do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/meeting_notes').to(route_to('meeting_notes#index'))
    end

    it 'routes to #new' do
      expect(get: '/meeting_notes/new').to(route_to('meeting_notes#new'))
    end

    it 'routes to #show' do
      expect(get: '/meeting_notes/1').to(route_to('meeting_notes#show', id: '1'))
    end

    it 'routes to #edit' do
      expect(get: '/meeting_notes/1/edit').to(route_to('meeting_notes#edit', id: '1'))
    end

    it 'routes to #create' do
      expect(post: '/meeting_notes').to(route_to('meeting_notes#create'))
    end

    it 'routes to #update via PUT' do
      expect(put: '/meeting_notes/1').to(route_to('meeting_notes#update', id: '1'))
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/meeting_notes/1').to(route_to('meeting_notes#update', id: '1'))
    end

    it 'routes to #destroy' do
      expect(delete: '/meeting_notes/1').to(route_to('meeting_notes#destroy', id: '1'))
    end
  end
end
