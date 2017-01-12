package com.company;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.List;

public class Dragon extends JFrame {

    public Dragon() {
        this.setTitle("Dragon");
        this.setSize(new Dimension(500, 500));
        this.setResizable(true);
        this.setLocationRelativeTo(null);


        this.setVisible(true);
    }

    public Point pointAIntercaler(Point a, Point b) {
        return new Point((a.getX() + b.getX())/2 + (b.getY() - a.getY())/2, (a.getY() + b.getY())/2 + (a.getX() - b.getX())/2);
    }

    public Path pasDragon(Path path) {

        if(path.getPath().isEmpty()) {
            return new Path();
        } else if (path.getPath().size() == 1) {
            return path;
        } else {
            return null;
        }
    }

    @Override
    public void paintComponents(Graphics g) {
        super.paintComponents(g);
    }

    public static void main(String[] args) {
	    SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new Dragon();
            }
        });
    }

    public class Point {
        private float x;
        private float y;

        public Point(float x, float y) {
            this.x = x;
            this.y = y;
        }

        public float getX() {
            return x;
        }

        public float getY() {
            return y;
        }
    }

    public class Path {
        private List<Point> path;

        public Path() {
            this.path = new ArrayList<>();
        }

        public List<Point> getPath() {
            return path;
        }

        public void addPoint(int x, int y) {
            this.path.add(new Point(x,y));
        }

        public void addPoint(Point point) {
            this.path.add(point);
        }
    }
}
