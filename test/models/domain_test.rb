require 'test_helper'

class DomainTest < ActiveSupport::TestCase
  setup do
    @domain = domains(:one)
  end

  test "knows the host" do
    assert_equal "911.gov", @domain.host
  end

  test "normalizes the host" do
    domain = Domain.new :host => " 911.GoV "
    domain.normalize_host
    assert_equal "911.gov", domain.host
  end

  test "inits the inspector" do
    assert_equal SiteInspector::Domain, @domain.inspector.class
  end

  test "returns the URL" do
    domain = Domain.new :host => "911.gov"
    domain.https = false
    domain.root = true
    assert_equal "http://911.gov", @domain.url
  end

  test "crawls the domain" do
    Domain.find_by(:host => "fcc.gov").destroy
    VCR.use_cassette :fcc, :record => :new_episodes do
      domain = Domain.new :host => "fcc.gov"
      assert_equal nil, domain.server
      domain.crawl!
      assert_equal "Apache", domain.server
    end
  end

  test "validates government domain-ness" do
    domain = Domain.new :host => "github.com"
    assert_raise ActiveRecord::RecordInvalid do
      domain.save!
    end
  end

  test "stores the CDN" do
    @domain.content_delivery_network = nil
    @domain.save!
    assert_equal nil, @domain.cdn

    @domain.cdn = "akamai"
    assert_equal "akamai", @domain.cdn

    assert_raise ActiveRecord::RecordInvalid do
      @domain.cdn = "foo"
    end
  end

  test "stores the framework" do
    @domain.framework = nil
    @domain.save!
    assert_equal nil, @domain.framework

    @domain.framework = Framework.find_or_create_by! :name => "wordpress"
    assert_equal "wordpress", @domain.framework.name

    assert_raise ActiveRecord::RecordInvalid do
      Framework.find_or_create_by! :name => "foo"
    end
  end


  test "stores the JS" do
    @domain.javascript_library = nil
    @domain.save!
    assert_equal nil, @domain.javascript

    @domain.javascript = "jquery"
    assert_equal "jquery", @domain.javascript

    assert_raise ActiveRecord::RecordInvalid do
      @domain.javascript = "foo"
    end
  end

  test "stores the analytics provider" do
    @domain.analytics_provider = nil
    @domain.save!
    assert_equal nil, @domain.analytics

    @domain.analytics = :google_analytics
    assert_equal "google_analytics", @domain.analytics.name

    assert_raise ActiveRecord::RecordInvalid do
      @domain.analytics = :foo
    end
  end

  test "find by id" do
    assert_equal @domain, Domain.find(@domain.id)
  end

  test "find by host" do
    assert_equal @domain, Domain.find(@domain.host)
  end

  test "find by slug" do
    assert_equal @domain, Domain.find(@domain.slug)
  end
end
