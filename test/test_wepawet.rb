require 'helper'

class TestWepawet < Test::Unit::TestCase
	should "submit submit http://example.com for analysis" do
		config = {
			'wepawetSubmitUrl' => 'http://wepawet.cs.ucsb.edu/services/upload.php', 
			'wepawetQueryUrl' => 'http://wepawet.cs.ucsb.edu/services/query.php',
			'wepawetDomainUrl' => 'http://wepawet.cs.ucsb.edu/services/domain.php',
			'wepawetUrlUrl' => 'http://wepawet.cs.ucsb.edu/services/url.php',
		}
		w = Wepawet::Submit.new(config)
		hash = w.submit_url("http://example.com")
		assert_equal(32, hash.length)
		assert(hash =~ /^[a-fA-F0-9]{32}$/)
		q = Wepawet::Query.new(config)
		resp = q.by_taskid(hash)
		assert("http://example.com", resp['url'])
		resp = q.by_domain("example.com")
		assert("example.com", resp['domain'])
		resp = q.by_url("http://example.com")
		assert("http://example.com", resp['url'])
	end
end
