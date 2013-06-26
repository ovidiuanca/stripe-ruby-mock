module StripeMock
  module Util

    def self.rmerge(desh_hash, source_hash)
      return source_hash if desh_hash.nil?
      return nil if source_hash.nil?

      desh_hash.merge(source_hash) do |key, oldval, newval|
        if oldval.is_a?(Array) && newval.is_a?(Array)
          oldval.zip(newval).map {|elems|
            elems[1].nil? ? elems[0] : rmerge(elems[0], elems[1])
          }
        elsif oldval.is_a?(Hash) && newval.is_a?(Hash)
          rmerge(oldval, newval)
        else
          newval
        end
      end
    end

  end
end
