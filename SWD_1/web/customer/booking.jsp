<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<%-- 
    Document   : success
    Created on : 18 thg 3, 2026, 23:01:46
    Author     : hieunthe181854
--%>
<html>
    <head>
        <title>Đặt tài xế</title>
        <script src="https://cdn.tailwindcss.com"></script>

        <style>
            .suggestions {
                border: 1px solid #ddd;
                max-height: 150px;
                overflow-y: auto;
                background: white;
                position: absolute;
                width: 100%;
                z-index: 50;
            }
            .suggestions div {
                padding: 8px;
                cursor: pointer;
            }
            .suggestions div:hover {
                background: #eee;
           }
        </style>
    </head>

    <body class="bg-gray-100 p-10">

        <form action="${pageContext.request.contextPath}/booking" method="POST">

            <!-- PICKUP -->
            <input type="text" id="pickupInput" placeholder="Điểm đón" class="w-full p-3 border mb-2">
            <div id="pickupSuggestions" class="suggestions"></div>

            <!-- DEST -->
            <input type="text" id="destInput" placeholder="Điểm đến" class="w-full p-3 border mt-4 mb-2">
            <div id="destSuggestions" class="suggestions"></div>

            <!-- hidden -->
            <input type="hidden" name="pickupLat" id="pickupLat">
            <input type="hidden" name="pickupLng" id="pickupLng">
            <input type="hidden" name="destLat" id="destLat">
            <input type="hidden" name="destLng" id="destLng">

            <!-- GIÁ -->
            <%
                Object price = request.getAttribute("estimatedPrice");
                if (price != null) {
            %>
            <div class="bg-blue-100 p-3 mt-3">
                Giá dự kiến: <b><%= price %> đ</b>
            </div>
            <%
                }
            %>

            <!-- BUTTON -->
            <button type="submit" name="action"
                    value="<%= (price == null) ? "calculate" : "confirm" %>"
                    class="bg-blue-600 text-white w-full p-3 mt-4">
                <%= (price == null) ? "Xem giá" : "Xác nhận đặt xe" %>
            </button>

        </form>

        <!-- MESSAGE -->
        <%
            String msg = (String) session.getAttribute("message");
            if (msg != null) {
        %>
        <div class="mt-4 p-3 bg-green-200">
            <%= msg %>
        </div>
        <%
                session.removeAttribute("message");
            }
        %>

        <script>
            let timeout = null;

            function debounce(func, delay) {
                return function () {
                    clearTimeout(timeout);
                    timeout = setTimeout(func, delay);
                };
            }

            function searchLocation(query, callback) {
                fetch("https://nominatim.openstreetmap.org/search?format=json&q=" + encodeURIComponent(query))
                        .then(res => res.json())
                        .then(data => callback(data));
            }

        // pickup
            document.getElementById("pickupInput").addEventListener("input",
                    debounce(function () {
                        let query = this.value;
                        if (query.length < 3)
                            return;

                        searchLocation(query, function (results) {
                            let box = document.getElementById("pickupSuggestions");
                            box.innerHTML = "";

                            results.forEach(place => {
                                let div = document.createElement("div");
                                div.innerText = place.display_name;

                                div.onclick = function () {
                                    pickupInput.value = place.display_name;
                                    pickupLat.value = place.lat;
                                    pickupLng.value = place.lon;
                                    box.innerHTML = "";
                                };

                                box.appendChild(div);
                            });
                        });
                    }, 400)
                    );

        // dest
            document.getElementById("destInput").addEventListener("input",
                    debounce(function () {
                        let query = this.value;
                        if (query.length < 3)
                            return;

                        searchLocation(query, function (results) {
                            let box = document.getElementById("destSuggestions");
                            box.innerHTML = "";

                            results.forEach(place => {
                                let div = document.createElement("div");
                                div.innerText = place.display_name;

                                div.onclick = function () {
                                    destInput.value = place.display_name;
                                    destLat.value = place.lat;
                                    destLng.value = place.lon;
                                    box.innerHTML = "";
                                };

                                box.appendChild(div);
                            });
                        });
                    }, 400)
                    );
        </script>

    </body>
</html>