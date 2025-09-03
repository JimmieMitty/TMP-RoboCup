
import time

import rerun as rr
import rclpy
from rclpy.node import Node


class RerunLoggerNode(Node):
    def __init__(self):
        super().__init__('rerun_logger_node')
        rr.init("rerun_example_serve_web_viewer")
        self.server_uri = rr.serve_grpc()
        self.get_logger().info("Rerun gRPC server started.")

def main(args=None):
    rclpy.init(args=args)
    node = RerunLoggerNode()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        node.get_logger().info("Shutting down server...")
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()
