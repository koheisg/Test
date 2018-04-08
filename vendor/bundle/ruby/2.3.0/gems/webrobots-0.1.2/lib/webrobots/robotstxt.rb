#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'


require 'strscan'

class WebRobots
  class Error < StandardError
  end

  class ParseError < Error
    # The site's root URI
    attr_reader :site

    def initialize(message, site)
      @message = message
      @site = site
    end

    def to_s
      @message
    end
  end

  class RobotsTxt
class Parser < Racc::Parser

module_eval(<<'...end robotstxt.ry/module_eval...', 'robotstxt.ry', 171)

      def initialize(target, crawl_delay_handler = nil)
        super()
        @target = target
        @crawl_delay_handler = crawl_delay_handler
      end

      def parse!(input, site)
        parse(input, site)
      rescue Error => e
        RobotsTxt.new(site, nil,
          :error => e,
          :target => @target,
          :crawl_delay_handler => @crawl_delay_handler)
      end

      KNOWN_TOKENS = %w[User-agent Allow Disallow Crawl-delay Sitemap]
      RE_KNOWN_TOKENS = /\A(#{KNOWN_TOKENS.map { |t| Regexp.quote(t) }.join('|')})\z/i

      def parse(input, site)
        @q ||= []
        @errors = []
        @lineno = 0
        @site = site

        string = input.respond_to?(:read) ? input.read : input
        s = StringScanner.new(string)
        value_expected = false

        until s.eos?
          @lineno += 1 if s.bol?
          if t = s.scan(/[ \t]*(?:\r?\n|\z)/)
            if value_expected
              @q << [:VALUE, '']
            end
            @q << [:EOL, t]
            value_expected = false
          elsif t = s.scan(/[ \t]+/)
            @q << [:SPACE, t]
          elsif t = s.scan(/:/)
            @q << [t, t]
            value_expected = true
          elsif t = s.scan(/#.*/)
            if value_expected
              @q << [:VALUE, '']
            end
            @q << [:COMMENT, t]
          else
            if value_expected
              if t = s.scan(/.*?(?=[ \t]*(?:#|$))/)
                @q << [:VALUE, t]
              else
                parse_error @lineno, "unexpected characters: %s" % s.check(/.*/)
              end
              value_expected = false
            elsif t = s.scan(/[^\x00-\x1f\x7f()<>@,;:\\"\/\[\]?={}]+/)
              case t
              when RE_KNOWN_TOKENS
                @q << [t.downcase, t]
              else
                @q << [:TOKEN, t]
              end
            else
              parse_error "unexpected characters: %s" % s.check(/.*/)
            end
          end
        end

        @q << [:EOL, ''] if !@q.empty? && @q.last.first != :EOL

        @pos = -1

        do_parse
      rescue Racc::ParseError => e
        raise ParseError.new(e.message, @site)
      ensure
        @q.clear
      end

      def next_token
        @q[@pos += 1]
      end

      def on_error(token_id, value, stack)
        parse_error "unexpected %s: %s" % [token_to_str(token_id), value]
      end

      def parse_error(message)
        message = "%s line %d: %s" % [@site.to_s, @lineno, message]
        if @lax
          @errors << message
        else
          raise Racc::ParseError, message
        end
      end

...end robotstxt.ry/module_eval...
##### State transition tables begin ###

racc_action_table = [
     5,    12,   -10,    16,    52,    40,   -12,    36,    37,    38,
    39,    12,   -10,    16,    46,    27,    27,    36,    37,    38,
    39,    12,   -10,    16,    49,    50,    51,    36,    37,    38,
    39,    12,   -10,    16,    12,    53,    24,    36,    37,    38,
    39,    12,   -10,    16,    12,    12,   -12,    12,   -10,    16,
    60,    12,   -13,    16,    60,    12,    12,    16,    60,    12,
    12,    16,    60,    12,    12,    16,    60,    12,    23,    16,
    60,    12,    62,    16,    63,    64,    65,    66,     5,     9,
     5,     6,     5 ]

racc_action_check = [
    21,    21,    21,    21,    39,    23,    21,    21,    21,    21,
    21,    25,    25,    25,    27,    19,    25,    25,    25,    25,
    25,    45,    45,    45,    36,    37,    38,    45,    45,    45,
    45,    29,    29,    29,    24,    41,    16,    29,    29,    29,
    29,     7,     7,     7,    46,    49,     7,    13,    13,    13,
    62,    62,    13,    62,    53,    53,    50,    53,    63,    63,
    51,    63,    64,    64,    52,    64,    65,    65,    15,    65,
    66,    66,    54,    66,    55,    56,    57,    58,    11,     6,
     3,     1,     0 ]

racc_action_pointer = [
    80,    81,   nil,    78,   nil,   nil,    79,    38,   nil,   nil,
   nil,    76,   nil,    44,   nil,    64,    30,   nil,   nil,     7,
   nil,    -2,   nil,     3,    31,     8,   nil,     8,   nil,    28,
   nil,   nil,   nil,   nil,   nil,   nil,    18,    19,    20,    -2,
   nil,    28,   nil,   nil,   nil,    18,    41,   nil,   nil,    42,
    53,    57,    61,    52,    65,    67,    68,    69,    70,   nil,
   nil,   nil,    48,    56,    60,    64,    68,   nil,   nil,   nil,
   nil,   nil ]

racc_action_default = [
    -5,   -44,    -1,    -6,    -7,    -9,   -44,    -3,    -8,    72,
    -2,    -5,   -11,   -23,   -14,   -44,   -44,   -18,   -19,   -44,
    -4,    -6,   -15,   -44,   -10,   -29,   -25,   -44,   -20,   -21,
   -22,   -31,   -34,   -35,   -36,   -37,   -44,   -44,   -44,   -44,
   -16,   -44,   -24,   -26,   -27,   -30,   -10,   -32,   -33,   -10,
   -10,   -10,   -10,   -10,   -44,   -44,   -44,   -44,   -44,   -17,
   -42,   -43,   -10,   -10,   -10,   -10,   -10,   -28,   -38,   -39,
   -40,   -41 ]

racc_goto_table = [
    14,    41,     8,    47,     3,     2,    22,    17,    29,    11,
    18,    26,    45,    10,    14,    21,    20,    43,    44,    47,
     8,    28,    48,    54,    30,    25,    55,    56,    57,    58,
    59,    42,     7,     1,   nil,   nil,   nil,   nil,    48,    67,
    68,    69,    70,    71 ]

racc_goto_check = [
    11,     8,     7,    19,     6,     2,    11,    13,    15,     5,
    14,    18,    15,     3,    11,     6,     2,    18,    11,    19,
     7,    13,    11,     8,    14,    16,     8,     8,     8,     8,
    12,    17,     4,     1,   nil,   nil,   nil,   nil,    11,    12,
    12,    12,    12,    12 ]

racc_goto_pointer = [
   nil,    33,     5,     6,    30,     2,     4,    -1,   -23,   nil,
   nil,    -7,   -23,     0,     3,   -13,     6,     6,    -8,   -26,
   nil,   nil,   nil,   nil ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,   nil,   nil,     4,    15,    19,
    13,    61,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    31,
    32,    33,    34,    35 ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 17, :_reduce_1,
  3, 14, :_reduce_2,
  0, 16, :_reduce_none,
  2, 16, :_reduce_none,
  0, 15, :_reduce_none,
  1, 15, :_reduce_none,
  1, 19, :_reduce_none,
  2, 19, :_reduce_none,
  1, 20, :_reduce_none,
  0, 21, :_reduce_none,
  1, 21, :_reduce_none,
  0, 22, :_reduce_none,
  1, 22, :_reduce_none,
  1, 23, :_reduce_none,
  2, 23, :_reduce_none,
  3, 24, :_reduce_none,
  5, 24, :_reduce_17,
  1, 18, :_reduce_18,
  1, 18, :_reduce_19,
  3, 18, :_reduce_20,
  3, 18, :_reduce_21,
  3, 18, :_reduce_none,
  1, 27, :_reduce_none,
  3, 26, :_reduce_24,
  1, 29, :_reduce_25,
  2, 29, :_reduce_26,
  2, 29, :_reduce_none,
  5, 31, :_reduce_28,
  0, 30, :_reduce_none,
  1, 30, :_reduce_none,
  1, 28, :_reduce_31,
  2, 28, :_reduce_32,
  2, 28, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  5, 33, :_reduce_38,
  5, 34, :_reduce_39,
  5, 35, :_reduce_40,
  5, 36, :_reduce_41,
  1, 25, :_reduce_none,
  1, 25, :_reduce_none ]

racc_reduce_n = 44

racc_shift_n = 72

racc_token_table = {
  false => 0,
  :error => 1,
  :EOL => 2,
  :SPACE => 3,
  :COMMENT => 4,
  "sitemap" => 5,
  ":" => 6,
  :VALUE => 7,
  "user-agent" => 8,
  "allow" => 9,
  "disallow" => 10,
  "crawl-delay" => 11,
  :TOKEN => 12 }

racc_nt_base = 13

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "EOL",
  "SPACE",
  "COMMENT",
  "\"sitemap\"",
  "\":\"",
  "VALUE",
  "\"user-agent\"",
  "\"allow\"",
  "\"disallow\"",
  "\"crawl-delay\"",
  "TOKEN",
  "$start",
  "robotstxt",
  "opt_blanklines",
  "body",
  "@1",
  "records",
  "blanklines",
  "blankline",
  "opt_space",
  "opt_commentlines",
  "commentlines",
  "comment",
  "eol_opt_comment",
  "record",
  "commentblock",
  "rulelines",
  "agentlines",
  "opt_rulelines",
  "agentline",
  "ruleline",
  "allowline",
  "disallowline",
  "crawldelayline",
  "extension" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 7)
  def _reduce_1(val, _values, result)
    			    @sitemaps = []
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 11)
  def _reduce_2(val, _values, result)
    			    body = val[2]
			    result = RobotsTxt.new(@site, body,
			      :target => @target,
                              :sitemaps => @sitemaps,
                              :crawl_delay_handler => @crawl_delay_handler)
			  
    result
  end
.,.,

# reduce 3 omitted

# reduce 4 omitted

# reduce 5 omitted

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

# reduce 10 omitted

# reduce 11 omitted

# reduce 12 omitted

# reduce 13 omitted

# reduce 14 omitted

# reduce 15 omitted

# reduce 16 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 44)
  def _reduce_17(val, _values, result)
    			    @sitemaps << val[3]
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 49)
  def _reduce_18(val, _values, result)
    			    result = []
			    result << val[0]
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 54)
  def _reduce_19(val, _values, result)
    			    result = []
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 60)
  def _reduce_20(val, _values, result)
    			    result << val[2]
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 66)
  def _reduce_21(val, _values, result)
    			    val[2].each_with_index { |line, i|
			      warn "%s line %d: %s: orphan rule line" %
			        [@site.to_s, @rulelinenos[i], line.token] if $VERBOSE
			    }
			  
    result
  end
.,.,

# reduce 22 omitted

# reduce 23 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 81)
  def _reduce_24(val, _values, result)
    			    result = Record.new(val[1], val[2])
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 86)
  def _reduce_25(val, _values, result)
    			    result = [val[0]]
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 91)
  def _reduce_26(val, _values, result)
    			    result << val[1]
			  
    result
  end
.,.,

# reduce 27 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 98)
  def _reduce_28(val, _values, result)
    			    result = AgentLine.new(val[0], val[3])
			  
    result
  end
.,.,

# reduce 29 omitted

# reduce 30 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 106)
  def _reduce_31(val, _values, result)
    			    result = [result]
			    @rulelinenos = []
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 112)
  def _reduce_32(val, _values, result)
    			    result << val[1]
			    @rulelinenos << @lineno
			  
    result
  end
.,.,

# reduce 33 omitted

# reduce 34 omitted

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

module_eval(<<'.,.,', 'robotstxt.ry', 125)
  def _reduce_38(val, _values, result)
    			    result = AllowLine.new(val[0], val[3])
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 130)
  def _reduce_39(val, _values, result)
    			    result = DisallowLine.new(val[0], val[3])
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 135)
  def _reduce_40(val, _values, result)
    			    result = CrawlDelayLine.new(val[0], val[3])
			  
    result
  end
.,.,

module_eval(<<'.,.,', 'robotstxt.ry', 140)
  def _reduce_41(val, _values, result)
    			    result = ExtentionLine.new(val[0], val[3])
			  
    result
  end
.,.,

# reduce 42 omitted

# reduce 43 omitted

def _reduce_none(val, _values, result)
  val[0]
end

end   # class Parser

    def initialize(site, records, options = nil)
      @timestamp = Time.now
      @site = site
      @options = options || {}
      @last_checked_at = nil

      @error = @options[:error]
      @target = @options[:target]
      @sitemaps = @options[:sitemaps] || []
      @crawl_delay_handler = @options[:crawl_delay_handler]

      if records && !records.empty?
        @records, defaults = [], []
        records.each { |record|
          if record.default?
            defaults << record
          elsif !@target || record.match?(@target)
            @records << record
          end
        }
        @records.concat(defaults)
      else
        @records = []
      end
    end

    attr_reader :timestamp, :site, :sitemaps
    attr_accessor :error

    def error!
      raise @error if @error
    end

    def target(user_agent = nil)
      if user_agent
        raise ArgumentError, "this instance is targeted for #{@target}" if @target
        user_agent
      else
        raise ArgumentError, "user_agent is mandatory for an untargeted instance" if !@target
        @target
      end
    end
    private :target

    def find_record(user_agent = nil)
      user_agent = target(user_agent)
      @records.find { |record|
        record.match?(user_agent)
      }
    end
    private :find_record

    def allow?(request_uri, user_agent = nil)
      record = find_record(user_agent) or return true
      allow = record.allow?(request_uri)
      if delay = record.delay and @crawl_delay_handler
        @crawl_delay_handler.call(delay, @last_checked_at)
      end
      @last_checked_at = Time.now
      return allow
    end

    def crawl_delay(user_agent = nil)
      record = find_record(user_agent) or return 0
      record.delay or return 0
    end

    def options(user_agent = nil)
      record = find_record(user_agent) or return {}
      record.options
    end

    DISALLOW_ALL = <<-TXT
User-Agent: *
Disallow: /
    TXT

    def self.unfetchable(site, reason, target = nil)
      Parser.new(target).parse(DISALLOW_ALL, site).tap { |robots_txt|
        robots_txt.error = reason
      }
    end

    class Record
      def initialize(agentlines, rulelines)
        @patterns = agentlines.map { |agentline| agentline.pattern }
        @acls = []
        @delay = nil
        @options = {}
        rulelines.each { |ruleline|
          case ruleline
          when AccessControlLine
            @acls << ruleline
          when CrawlDelayLine
            @delay = ruleline.delay
          else
            @options[ruleline.token.downcase] = ruleline.value
          end
        } if rulelines
        @acls.replace @acls.sort_by { |x|
          [-x.value.length, x.is_a?(AllowLine) ? -1 : 0]
        }
      end

      attr_reader :delay, :options

      def match?(user_agent)
        @patterns.any? { |pattern|
          pattern.match(user_agent)
        }
      end

      def default?
        @patterns.include?(//)
      end

      def allow?(request_uri)
        @acls.each { |acl|
          if acl.match?(request_uri)
            return acl.allow?
          end
        }
        return true
      end
    end

    class Line
      def initialize(token, value)
        @token = token
        @value = value
        compile
      end

      attr_reader :token, :value

      def compile
        self
      end
    end

    class AgentLine < Line
      def compile
        if @value == '*'
          @pattern = //
        else
          @pattern = Regexp.new(Regexp.quote(@value), Regexp::IGNORECASE)
        end
        self
      end

      attr_reader :pattern
    end

    class AccessControlLine < Line
      def compile
        @empty = @value.empty?
        re_src = '\A'
        s = StringScanner.new(@value)
        until s.eos?
          if t = s.scan(/[^%*$]+/)
            re_src << Regexp.quote(t)
          elsif t = s.scan(/%([0-9a-f]{2})/i)
            c = s[1].to_i(16)
            if c == 0x2f
              re_src << '%2[fF]'
            else
              re_src << Regexp.quote('%c' % c)
            end
          elsif t = s.scan(/\*/)
            re_src << '.*'
          elsif t = s.scan(/\$/)
            re_src << '\z'
            break
          else
            re_src << Regexp.quote(s.scan(/./))
          end
        end
        @pattern = Regexp.new(re_src, Regexp::MULTILINE)
        self
      end

      def match?(request_uri)
        return false if @empty
        transformed = request_uri.gsub(/(%2[fF])|%([0-9a-f]{2})/i) { $1 || '%c' % $2.to_i(16) }
        !!@pattern.match(transformed)
      end
    end

    class AllowLine < AccessControlLine
      def allow?
        true
      end
    end

    class DisallowLine < AccessControlLine
      def allow?
        false
      end
    end

    class CrawlDelayLine < Line
      def compile
        case @value
        when /\A((0|[1-9][0-9]*)\.[0-9]+)/
          @delay = @value.to_f
        when /\A(0|[1-9][0-9]*)/
          @delay = @value.to_i
        else
          @delay = nil
        end
        self
      end

      attr_reader :delay
    end

    class ExtentionLine < Line
    end
  end
end