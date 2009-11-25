require 'oauth/signature/base'

module OAuth::Signature::HMAC
  class Base < OAuth::Signature::Base

  private

    def digest
      if RUBY_VERSION =~ /1\.9/
        # use stdlib
        require 'digest/hmac'
        self.class.digest_class Object.module_eval("::Digest::#{self.class.digest_klass}")
        Digest::HMAC.hexdigest(secret, signature_base_string, self.class.digest_class)
      else 
        # use gem
        self.class.digest_class Object.module_eval("::HMAC::#{self.class.digest_klass}")
        self.class.digest_class.digest(secret, signature_base_string)
      end
    end
  end
end
