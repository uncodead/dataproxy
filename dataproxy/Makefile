run:
	@gunicorn wsgi:application --bind 0.0.0.0:5000 --log-level debug --log-file - --timeout 30000

debug: export FLASK_ENV=development
debug:
	python wsgi.py