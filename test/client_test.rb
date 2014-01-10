require 'test_helper'

class ClientLoginTest < MiniTest::Unit::TestCase

  def setup
    client = WunderMarkdown::Client.new
    VCR.use_cassette('client_login') do
      @email, @token = client.login("yannick.schutz@gmail.com", "1234")
    end
  end

  def test_login_returns_email
    assert_equal @email, 'yannick.schutz@gmail.com'
  end

  def test_login_returns_token
    assert_equal @token, 'token'
  end
end

class ClientListTest < MiniTest::Unit::TestCase

  def setup
    client = WunderMarkdown::Client.new("token")
    VCR.use_cassette('client_list') do
      @list = client.list("projects")
    end
  end

  def test_list_is_correct_instance
    assert_instance_of WunderMarkdown::List, @list
  end

  def test_list_has_correct_id
    assert_equal @list.id, "ABNSAAWFdcY"
  end

  def test_list_has_correct_name
    assert_equal @list.name, "projects"
  end
end

class ClientTasksTest < MiniTest::Unit::TestCase

  def setup
    client = WunderMarkdown::Client.new("token")
    VCR.use_cassette('client_tasks') do
      list = MiniTest::Mock.new
      list.expect(:id, "ABNSAAWFdcY")
      @tasks = client.tasks(list)
    end
  end

  def test_tasks_is_an_array
    assert_instance_of Array, @tasks
  end

  def test_tasks_has_2_elements
    assert_equal 2, @tasks.size
  end

  def test_tasks_are_correct_instances
    @tasks.each do |task|
      assert_instance_of WunderMarkdown::Task, task
    end
  end

  def test_task_has_correct_name
    assert_equal @tasks.first.title, "Issues lists"
  end
end
