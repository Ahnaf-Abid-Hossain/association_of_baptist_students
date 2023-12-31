require 'rails_helper'

RSpec.describe(LinksController) do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/links').to(route_to('links#index'))
    end

    it 'routes to #new' do
      expect(get: '/links/new').to(route_to('links#new'))
    end

    it 'routes to #edit' do
      expect(get: '/links/1/edit').to(route_to('links#edit', id: '1'))
    end

    it 'routes to #create' do
      expect(post: '/links').to(route_to('links#create'))
    end

    it 'routes to #update via PUT' do
      expect(put: '/links/1').to(route_to('links#update', id: '1'))
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/links/1').to(route_to('links#update', id: '1'))
    end

    it 'routes to #destroy' do
      expect(delete: '/links/1').to(route_to('links#destroy', id: '1'))
    end

    it 'routes to #up' do
      expect(patch: '/links/1/up').to(route_to('links#up', id: '1'))
    end

    it 'routes to #down' do
      expect(patch: '/links/1/down').to(route_to('links#down', id: '1'))
    end
  end
end
