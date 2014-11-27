module Enumerable
	def my_each
		for element in self
			yield(element)
		end
	end

	def my_each_with_index
		i = 0
		while i < self.length
			yield(self[i], i)
			i += 1
		end
		self
	end

	def my_select
		select = []
		for element in self
			if yield(element)
				select.push(element)
			end
		end
		select
	end

	def my_all?
		for element in self
			if block_given?
				unless yield(element)
					return false
				end
			else
				unless element
					return false
				end
			end
		end
		return true
	end

	def my_any?
		for element in self
			if block_given?
				if yield(element)
					return true
				end
			else
				if element
					return true
				end
			end
		end
		return false
	end

	def my_none?
		for element in self
			if block_given?
				if yield(element)
					return false
				end
			else
				if element
					return false
				end
			end
		end
		return true
	end

	def my_count(number=self.length)
		count = 0
		for element in self
			if block_given?
				if yield(element)
					count += 1
				end
			else
				count = number
			end
		end
		count
	end

	def my_map(code=nil)
		map_array = []
		for element in self
			# if block_given?
			# 	map_array.push(yield(element))
			# else
			# 	map_array.push(element)
			# end
			if code == nil
				map_array.push(element)
			elsif block_given?
				map_array.push(yield(code.call(element)))
			else
				map_array.push(code.call(element))			
			end
		end
		map_array
	end

	def my_inject(initial=nil, sym=nil) ## this got huge. 

		case initial

		when Numeric
			memo = initial
			case sym

			when Symbol
				for element in self
					case sym
					when :*
						memo = memo * element
					when :+
						memo = memo + element
					when :- 
						memo = memo - element
					when :/
						memo = memo/element
					when :%
						memo = memo % element
					else 
						return
					end		
				end			

			else
				for element in self
					memo = yield(memo, element)
				end
			end

		when Symbol
			skip = true
			for element in self
				if skip
					memo = element
					skip = false
				else
					case initial
					when :*
						memo = memo * element
					when :+
						memo = memo + element
					when :- 
						memo = memo - element
					when :/
						memo = memo/element
					when :%
						memo = memo % element
					else 
						return
					end
				end
			end

		else
			skip = true
			for element in self
				if skip
					memo = element
					skip = false

				else
					memo = yield(memo, element)	
				end
			end
		end
		memo
	end

end

	def multiply_els(array)
		array.my_inject(:*)
	end