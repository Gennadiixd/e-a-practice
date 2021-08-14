import React from "react";
import { BrowserRouter as Router } from "react-router-dom";

import { Card, CardContent } from "@material-ui/core/";
import RouteApp from "./route/RouteApp";

export default function BasicExample() {
  return (
    <Router>
      <Card elevation={3}>
        <CardContent>
          <RouteApp />
        </CardContent>
      </Card>
    </Router>
  );
}
