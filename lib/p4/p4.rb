module P4
  class P4
    def initialize(p4port, p4user, p4client)
      @env = {'p4port' => p4port, 'p4user' => p4user, 'p4client' => p4client}
    end

    def client_changelist
      self.changes("-m1 @#{@env['p4client']}") do |stdout|
        m = /^Change (?<changelist>\d+) on/.match(stdout)
        raise stdout unless m

        m[:changelist].to_i
      end
    end

    def client_root
      self.clients("-e #{@env['p4client']}") do |stdout|
        #FIXME possible hole when handling root w/ space
        m = /^Client #{@env['p4client']} \d+\/\d+\/\d+ root (?<root>.+) 'Created by /.match(stdout)
        raise stdout unless m

        m[:root]
      end
    end

    def submit(*params)
      self.method_missing(:submit, params) do |stdout|
        m = /Change (?<changelist>\d+) submitted./.match(stdout)
        raise stdout unless m

        m[:changelist].to_i
      end
    end

    def method_missing(sym, *params)
      cmd = "p4.exe #{sym.to_s} #{params.join(' ')}"
      puts cmd

      #FIXME how to deal w/ ERROR: message or the command doesn't return 0
      IO.popen(@env, cmd) do |pipe|
        stdout = pipe.read
        puts stdout

        block_given? ? yield(stdout) : stdout
      end
    end
  end
end