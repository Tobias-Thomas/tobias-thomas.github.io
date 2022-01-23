function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function hfun_blogposts()
    bloglist = readdir("blogposts")
    filter!(f -> endswith(f, ".md"), bloglist)
    sorter(p) = Date(pagevar("blogposts/$p", "pubdate"), dateformat"y-m-d")
    sort!(bloglist, by=sorter, rev=true)

    io = IOBuffer()
    write(io, """<ul class="blog-posts">""")
    for (i, post) in enumerate(bloglist)
        post == "index.md" && continue
        write(io, "<li><span><i>")
        url = "blogposts/$(post[1:end-3])"
        title = pagevar(url, "longtitle")
        pubdate = pagevar(url, "pubdate")
        date = Date(pubdate, dateformat"y-m-d")
        write(io, """$date</i></span><a href="/$url/">$title</a>""")
    end
    write(io, "</ul>")
    return String(take!(io))
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end
