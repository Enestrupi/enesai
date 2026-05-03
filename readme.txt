@app.route("/api/command/<token>")
def api_command_get(token):
    with _lock:
        cmd = _pending.get(token)
    if cmd:
        return jsonify({"pending": True, "type": cmd["type"], "body": cmd["body"], "id": token})
    r = jsonify({"pending": False})
    r.headers["Access-Control-Allow-Origin"] = "*"
    return r
