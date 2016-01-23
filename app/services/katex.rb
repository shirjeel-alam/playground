class Katex
  BLOCK_MATH_REGEX = /\$\$(.*?)\$\$/
  INLINE_MATH_REGEX = /\\\((.*?)\\\)/
  PATH = './vendor/assets/javascripts/katex.min.js'

  def self.renderMathInElement(content)
    katex = initializeKatex

    block_math_tokens = content.scan(BLOCK_MATH_REGEX).flatten
    inline_math_tokens = content.scan(INLINE_MATH_REGEX).flatten

    block_math_tokens.each do |token|
      content = content.gsub("$$#{token}$$", katex.call('katex.renderToString', token, { displayMode: true }))
    end
    inline_math_tokens.each do |token|
      content = content.gsub("\\(#{token}\\)", katex.call('katex.renderToString', token, { displayMode: false }))
    end
    content
  end

  def self.initializeKatex
    katexsrc = open(PATH).read
    ExecJS.compile(katexsrc)
  end
end