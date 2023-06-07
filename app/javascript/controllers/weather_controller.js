import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {

  connect() {
    console.log("Weather has been connected.")
    this.getWeatherByLocation()
  }

  getGeolocation() {
    return new Promise((resolve, reject) => {
      // Check if geolocation is supported by the browser
      if ("geolocation" in navigator) {
        // Prompt user for permission to access their location
        navigator.geolocation.getCurrentPosition(
          // Success callback function
          (position) => {
            // Get the user's latitude and longitude coordinates
            const lat = position.coords.latitude;
            const lng = position.coords.longitude;
          
            // Do something with the location data, e.g. display on a map
            const data = {latitude: lat, longitude: lng};
            resolve(data);
          },
          // Error callback function
          (error) => {
            // Handle errors, e.g. user denied location sharing permissions
            reject(error);
          }
        );
      } else {
        // Geolocation is not supported by the browser
        reject(new Error("Geolocation is not supported by this browser."));
      }
    });
  } 

  getWeatherByLocation() {
    this.getGeolocation()
      .then((data) => {
        let weatherFrame = document.getElementById("weather_show")

        let url = new URL(weatherFrame.src, window.location.origin)
        url.searchParams.set("latitude", data.latitude)
        url.searchParams.set("longitude", data.longitude)

        weatherFrame.src = url.toString()
      })
      .catch((error) => {
        console.error("Error getting user location:", error);
      });
  }
}
