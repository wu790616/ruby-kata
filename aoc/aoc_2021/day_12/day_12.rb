class Day12
  attr_accessor :data, :nodes

  def initialize
    @data  = File.readlines('day_12.txt', chomp: true).map { |line| line.split('-') }
    @nodes = {}
  end

  def call
    init_nodes

    part1 = find_all_paths([['start']], 0, [])
    part2 = find_all_paths_p2([{path: ['start'], mark_twice: false}], 0, [])

    puts "1: #{part1}, 2: #{part2}"
  end

  def init_nodes
    # init nodes
    all_nodes = data.flatten.uniq

    all_nodes.each do |node|
      items = data.select { |item| item.include?(node) }

      neighbors = items.map { |item| item.find { |v| v != node } }

      nodes[node] = neighbors
    end
  end

  def find_all_paths(paths, end_count, memo)
    return end_count if paths.empty?

    paths.each do |path|
      next_nodes = nodes[path.last].select do |nn|
        check_cave(path, nn)
      end

      next_nodes.each do |nn|
        if nn == 'end'
          end_count += 1
        else
          memo << path.dup.push(nn)
        end
      end
    end

    find_all_paths(memo, end_count, [])
  end

  def find_all_paths_p2(paths, end_count, memo)
    return end_count if paths.empty?

    paths.each do |path|
      next_nodes = nodes[path[:path].last].select do |nn|
        check_cave(path[:path], nn, path[:mark_twice])
      end

      next_nodes.each do |nn|
        if nn == 'end'
          end_count += 1
        else
          new_path = {
            path:       path[:path].dup << nn,
            mark_twice: path[:mark_twice] ? true : (!big?(nn) && path[:path].include?(nn))
          }

          memo << new_path
        end
      end
    end

    find_all_paths_p2(memo, end_count, [])
  end

  def big?(node)
    node == node.upcase
  end

  def check_cave(path, n_node, mark_twice = true)
    return true  if big?(n_node)
    return false if n_node == 'start'
    return false if mark_twice && path.include?(n_node)

    true
  end
end

Day12.new.call
