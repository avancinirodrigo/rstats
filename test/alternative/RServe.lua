
return {
	RServe = function(unitTest)
		local error_func = function()
			RServe()
		end

		unitTest:assertError(error_func, NamedArgumentsMsg())

		error_func = function()
			RServe{host = 2}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("host", "string", 2))

		error_func = function()
			RServe{host = "localhost"}
		end

		unitTest:assertError(error_func, defaultValueMsg("host", "localhost"))

		error_func = function()
			RServe{port = "abc"}
		end

		unitTest:assertError(error_func, incompatibleTypeMsg("port", "number", "abc"))

		error_func = function()
			RServe{port = 6311}
		end

		unitTest:assertError(error_func, defaultValueMsg("port", 6311))

		error_func = function()
			RServe{port = 987654}
		end

		unitTest:assertError(error_func, "Could not connect to RServe at localhost using port 987654.")
	end,