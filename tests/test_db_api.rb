$LOAD_PATH[0,0] = File.join(File.dirname(__FILE__), '..', 'lib')
require 'mongo'
require 'test/unit'

# NOTE: assumes Mongo is running
class DBAPITest < Test::Unit::TestCase

  def setup
    @db = XGen::Mongo::Driver::Mongo.new.db('ruby-mongo-test')
    @coll = @db.collection('test')
    @coll.clear
  end

  def teardown
    @coll.clear
  end

  def test_clear
    @coll.insert('a' => 1)
    assert_equal 1, @coll.count
    @coll.clear
    assert_equal 0, @coll.count
  end

  def test_insert
    @coll.insert('a' => 1)
    @coll.insert('a' => 2)
    @coll.insert('b' => 3)

    assert_equal 3, @coll.count
    docs = @coll.find().collect
    assert_equal 3, docs.length
    assert docs.include?('a' => 1)
    assert docs.include?('a' => 2)
    assert docs.include?('b' => 3)
  end
end
