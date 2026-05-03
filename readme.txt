2026-05-03T11:10:41.484537105Z Collecting gunicorn (from -r requirements.txt (line 2))
2026-05-03T11:10:41.485680025Z   Using cached gunicorn-25.3.0-py3-none-any.whl.metadata (5.5 kB)
2026-05-03T11:10:41.502807691Z Collecting blinker>=1.9.0 (from flask->-r requirements.txt (line 1))
2026-05-03T11:10:41.50393161Z   Using cached blinker-1.9.0-py3-none-any.whl.metadata (1.6 kB)
2026-05-03T11:10:41.524965413Z Collecting click>=8.1.3 (from flask->-r requirements.txt (line 1))
2026-05-03T11:10:41.526327387Z   Using cached click-8.3.3-py3-none-any.whl.metadata (2.6 kB)
2026-05-03T11:10:41.541596711Z Collecting itsdangerous>=2.2.0 (from flask->-r requirements.txt (line 1))
2026-05-03T11:10:41.54268822Z   Using cached itsdangerous-2.2.0-py3-none-any.whl.metadata (1.9 kB)
2026-05-03T11:10:41.560758932Z Collecting jinja2>=3.1.2 (from flask->-r requirements.txt (line 1))
2026-05-03T11:10:41.561878061Z   Using cached jinja2-3.1.6-py3-none-any.whl.metadata (2.9 kB)
2026-05-03T11:10:41.61274803Z Collecting markupsafe>=2.1.1 (from flask->-r requirements.txt (line 1))
2026-05-03T11:10:41.613882309Z   Using cached markupsafe-3.0.3-cp314-cp314-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl.metadata (2.7 kB)
2026-05-03T11:10:41.639754756Z Collecting werkzeug>=3.1.0 (from flask->-r requirements.txt (line 1))
2026-05-03T11:10:41.640828735Z   Using cached werkzeug-3.1.8-py3-none-any.whl.metadata (4.0 kB)
2026-05-03T11:10:41.660634507Z Collecting packaging (from gunicorn->-r requirements.txt (line 2))
2026-05-03T11:10:41.661711245Z   Using cached packaging-26.2-py3-none-any.whl.metadata (3.5 kB)
2026-05-03T11:10:41.668157647Z Using cached flask-3.1.3-py3-none-any.whl (103 kB)
2026-05-03T11:10:41.669323007Z Using cached gunicorn-25.3.0-py3-none-any.whl (208 kB)
2026-05-03T11:10:41.670520618Z Using cached blinker-1.9.0-py3-none-any.whl (8.5 kB)
2026-05-03T11:10:41.67181957Z Using cached click-8.3.3-py3-none-any.whl (110 kB)
2026-05-03T11:10:41.673013021Z Using cached itsdangerous-2.2.0-py3-none-any.whl (16 kB)
2026-05-03T11:10:41.674056589Z Using cached jinja2-3.1.6-py3-none-any.whl (134 kB)
2026-05-03T11:10:41.675385472Z Using cached markupsafe-3.0.3-cp314-cp314-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl (23 kB)
2026-05-03T11:10:41.676480561Z Using cached werkzeug-3.1.8-py3-none-any.whl (226 kB)
2026-05-03T11:10:41.677677272Z Using cached packaging-26.2-py3-none-any.whl (100 kB)
2026-05-03T11:10:41.698482011Z Installing collected packages: packaging, markupsafe, itsdangerous, click, blinker, werkzeug, jinja2, gunicorn, flask
2026-05-03T11:10:42.38038738Z 
2026-05-03T11:10:42.382013849Z Successfully installed blinker-1.9.0 click-8.3.3 flask-3.1.3 gunicorn-25.3.0 itsdangerous-2.2.0 jinja2-3.1.6 markupsafe-3.0.3 packaging-26.2 werkzeug-3.1.8
2026-05-03T11:10:42.386641799Z 
2026-05-03T11:10:42.386654389Z [notice] A new release of pip is available: 25.3 -> 26.1
2026-05-03T11:10:42.386657589Z [notice] To update, run: pip install --upgrade pip
2026-05-03T11:10:47.4948498Z ==> Uploading build...
2026-05-03T11:10:51.437963854Z ==> Uploaded in 1.5s. Compression took 2.4s
2026-05-03T11:10:51.515045275Z ==> Build successful 🎉
2026-05-03T11:10:54.18386181Z ==> Deploying...
2026-05-03T11:10:54.266502387Z ==> Setting WEB_CONCURRENCY=1 by default, based on available CPUs in the instance
2026-05-03T11:11:03.098677572Z ==> Running 'gunicorn server:app'
2026-05-03T11:11:10.689367754Z [2026-05-03 11:11:10 +0000] [55] [INFO] Starting gunicorn 25.3.0
2026-05-03T11:11:10.689762385Z [2026-05-03 11:11:10 +0000] [55] [INFO] Listening at: http://0.0.0.0:10000 (55)
2026-05-03T11:11:10.690266629Z [2026-05-03 11:11:10 +0000] [55] [INFO] Using worker: sync
2026-05-03T11:11:10.693022383Z [2026-05-03 11:11:10 +0000] [56] [INFO] Booting worker with pid: 56
2026-05-03T11:11:11.289163737Z 127.0.0.1 - - [03/May/2026:11:11:11 +0000] "HEAD / HTTP/1.1" 404 0 "-" "Go-http-client/1.1"
2026-05-03T11:11:11.797730753Z [2026-05-03 11:11:11 +0000] [55] [INFO] Control socket listening at /opt/render/.gunicorn/gunicorn.ctl
2026-05-03T11:11:15.173877997Z ==> Your service is live 🎉
2026-05-03T11:11:15.315732336Z ==> 
2026-05-03T11:11:15.321184276Z ==> ///////////////////////////////////////////////////////////
2026-05-03T11:11:15.325219785Z ==> 
2026-05-03T11:11:15.329434336Z ==> Available at your primary URL https://backend-xrd1.onrender.com
2026-05-03T11:11:15.334378739Z ==> 
2026-05-03T11:11:15.340778252Z ==> ///////////////////////////////////////////////////////////