defmodule Releases do
  @version Mix.Project.config()[:version]

  def create_git_tag!() do
    {_, 0} =
      System.cmd("git", ["tag", "-a", "v#{@version}", "-m", "version #{@version}"],
        into: IO.stream(:stdio, :line)
      )
  end

  def publish_git_tag!() do
    {_, 0} = System.cmd("git", ["push", "origin", "v#{@version}"], into: IO.stream(:stdio, :line))
  end

  def release() do
    create_git_tag!()
    publish_git_tag!()
  end
end

Releases.release()
