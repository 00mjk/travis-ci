require 'spec_helper'
require 'support/active_record'
require 'support/pusher'

describe Travis::Notifications::Pusher do
  include Support::ActiveRecord, Support::Pusher

  before do
    Travis.config.notifications = [:pusher]
    Travis::Notifications::Pusher.send(:public, :queue_for, :payload_for)
  end

  after do
    Travis.config.notifications.clear
    Travis::Notifications.instance_variable_set(:@subscriptions, nil)
    Travis::Notifications::Pusher.send(:protected, :queue_for, :payload_for)
  end

  let(:receiver) { Travis::Notifications::Pusher.new }
  let(:job)      { Factory(:request).job }
  let(:build)    { Factory(:build, :config => { :rvm => ['1.8.7', '1.9.2'] }) }

  describe 'sends a message to pusher' do
    it 'build:queued' do
      Travis::Notifications.dispatch('build:queued', build)
      pusher.should have_message('build:queued', build)
    end

    it 'build:removed' do
      Travis::Notifications.dispatch('build:removed', build)
      pusher.should have_message('build:removed', build)
    end

    it 'build:started' do
      Travis::Notifications.dispatch('build:started', build)
      pusher.should have_message('build:started', build)
    end

    it 'build:log' do
      Travis::Notifications.dispatch('build:log', build)
      pusher.should have_message('build:log', build)
    end

    it 'build:finished' do
      Travis::Notifications.dispatch('build:finished', build)
      pusher.should have_message('build:finished', build)
    end

    it 'job:test:started' do
      Travis::Notifications.dispatch('job:test:started', job)
      pusher.should have_message('build:removed', job)
    end

  end

  describe 'payload_for returns the payload required for client side job events' do
    it 'build:queued' do
      receiver.payload_for('build:queued', job) == [:build, :repository]
    end

    it 'build:removed' do
      receiver.payload_for('build:removed', build) == [:build, :repository]
    end

    it 'build:started' do
      receiver.payload_for('build:started', build) == [:build, :repository]
    end

    it 'build:log' do
      receiver.payload_for('build:log', build, :log => 'foo') == [:build, :repository, :log]
    end

    it 'build:finished' do
      receiver.payload_for('build:finished', build).keys.should == [:build, :repository]
    end
  end

  describe 'queue_for' do
    it 'returns "jobs" for the event "build:queued"' do
      receiver.queue_for('build:queued', Factory(:build)).should == 'jobs'
    end

    it 'returns "jobs" for the event "build:removed"' do
      receiver.queue_for('build:removed', Factory(:build)).should == 'jobs'
    end

    it 'returns "builds" for the event "build:started"' do
      receiver.queue_for('build:started', Factory(:build)).should == 'builds'
    end

    it 'returns "builds" for the event "build:finished"' do
      receiver.queue_for('build:finished', Factory(:build)).should == 'builds'
    end

    it 'returns "build-1" for the event "build:log"' do
      receiver.queue_for('build:log', Factory(:build, :id => 1)).should == 'build-1'
    end
  end
end
